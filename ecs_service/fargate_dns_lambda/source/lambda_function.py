import boto3
import json
import os
ec2 = boto3.resource('ec2')
r53 = boto3.client('route53')

def lambda_handler(event, context):
    print(event)

    action = ""
    if event['detail']['desiredStatus'] == "STOPPED":
        action = "DELETE"
    elif event['detail']['desiredStatus'] == "RUNNING":
        action = "UPSERT"

    eni_id = list(filter(lambda a: a['name'] == "networkInterfaceId", event['detail']['attachments'][0]['details']))[0]['value']
    network_interface = ec2.NetworkInterface(eni_id)
    public_ip = network_interface.association_attribute['PublicIp']

    hosted_zone_id = os.environ['HOSTED_ZONE_ID']
    dns_name = os.environ['DNS_NAME']
    hosted_zone_apex = r53.get_hosted_zone(Id=hosted_zone_id)['HostedZone']['Name']

    dns_record_name = "{}.{}".format(dns_name, hosted_zone_apex)
    dns_record_comment = 'This record is maintained by {}.'.format(context.function_name)

    print(f"Attempting to do {action} for ENI {eni_id}. Linking IP {public_ip} to A type DNS {dns_record_name}.")

    r53.change_resource_record_sets(
    ChangeBatch={
            'Changes': [
                {
                    'Action': action,
                    'ResourceRecordSet': {
                        'Name': dns_record_name,
                        'ResourceRecords': [
                            {
                                'Value': public_ip,
                            },
                        ],
                        'TTL': 300,
                        'Type': 'A',
                    },
                },
            ],
            'Comment': dns_record_comment,
        },
        HostedZoneId=hosted_zone_id,
    )

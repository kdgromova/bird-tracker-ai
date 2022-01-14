import simplejson as json
import boto3
from boto3.dynamodb.conditions import Key, Attr
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('bird-feeder-db')

def get_birds(event, context):
    response = table.query(
        IndexName='SK-PK',
        KeyConditionExpression=Key('SK').eq('stats')
    )
    items = response['Items']
    print(items)

    body = {
        "birds": items,
    }

    response = {"statusCode": 200, "body": json.dumps(body)}

    return response


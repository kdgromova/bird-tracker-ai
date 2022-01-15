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

    body = {
        "birds": items,
    }

    response = {"statusCode": 200, "body": json.dumps(body)}

    return response

def get_bird_videos(event, context):
    species = event['pathParameters']['species'].upper()
    response = table.query(
        KeyConditionExpression=Key('PK').eq('species#'+species)
    )
    items = response['Items']
    
    body = {
        "videos": items,
    }
    
    response = {"statusCode": 200, "body": json.dumps(body)}
    return response

def get_video(event, context):
    # Example: 2022_01_01_20-12-11
    video = event['pathParameters']['video'].replace("_", "/")
    response = table.query(
        IndexName='SK-PK',
        KeyConditionExpression=Key('SK').eq('video#'+video)
    )
    items = response['Items']
    
    body = {
        "birds": items,
    }
    
    response = {"statusCode": 200, "body": json.dumps(body)}
    return response
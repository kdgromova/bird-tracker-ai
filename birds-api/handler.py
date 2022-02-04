import simplejson as json
import boto3
from boto3.dynamodb.conditions import Key, Attr, Not
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

    # Query videos only
    response = table.query(
        KeyConditionExpression=Key('PK').eq('species#'+species) & Key('SK').begins_with('video#'),
        ScanIndexForward=False
    )
    videos = response['Items']

    # Get stats record
    response = table.get_item(
        Key={ 'PK': 'species#'+species, 'SK': 'stats' }
    )
    stats = response['Item']
    
    body = {
        "videos": videos,
        "stats": stats
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
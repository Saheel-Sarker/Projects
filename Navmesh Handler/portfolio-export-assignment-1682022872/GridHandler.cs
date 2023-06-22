using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

//Assignment 1 Script
public class GridHandler : NodeHandler
{
    private float gridSize;

    //Holds all of the nodes
    private Dictionary<string, GraphNode> nodeDictionary;
    public override void CreateNodes()
    {
        nodeDictionary = new Dictionary<string, GraphNode>();

        //ASSIGNMENT 1 EDIT BELOW THIS LINE

        gridSize = ObstacleHandler.Instance.GridSize;//0.2f is the distance from the centre of one grid cell to an adjacent one
        float padding = gridSize/2.0f + 0.025f;
        for (float x = ObstacleHandler.Instance.XBound * -1; x <= ObstacleHandler.Instance.XBound + gridSize; x += gridSize) {
            //Is this grid cell fully in an obstacle
            //Does an obstacles lines intersect with the grid lines?
            //Is there an obstacle fully inside the grid
            
            for (float y = ObstacleHandler.Instance.YBound * -1; y <= ObstacleHandler.Instance.YBound + gridSize; y += gridSize) {
                Vector2 loc = new Vector2(x, y);
                Vector3 locVector3 = loc;

                Vector2 topLeft = new Vector2(x-padding, y+padding);
                Vector2 topRight = new Vector2(x+padding, y+padding);
                Vector2 bottomLeft = new Vector2(x-padding, y-padding);
                Vector2 bottomRight = new Vector2(x+padding, y-padding); 

                Polygon gridSquare = new Polygon(new Vector2[] {topLeft, topRight, bottomLeft, bottomRight});
                bool insideGridCell = false;
                foreach(Vector2 point in ObstacleHandler.Instance.GetObstaclePoints()){  // Checks if obstacles is in a grid cell
                    if(gridSquare.ContainsPoint(point)){
                        insideGridCell = true;
                        break;
                    }
                }
                
                bool intersectsWithGridCell = false;
                if (ObstacleHandler.Instance.AnyIntersect(topLeft, topRight) 
                || ObstacleHandler.Instance.AnyIntersect(topLeft, bottomLeft) 
                || ObstacleHandler.Instance.AnyIntersect(bottomLeft, bottomRight)
                || ObstacleHandler.Instance.AnyIntersect(bottomRight, topRight)){ // Checks if obstacles and grid cell intersect anywhere
                    intersectsWithGridCell = true;
                }  

                if (!intersectsWithGridCell
                && !insideGridCell
                && !ObstacleHandler.Instance.PointInObstacles(loc)){
                    nodeDictionary.Add(locVector3.ToString(), new GraphNode(locVector3));
                }
            }
            
        }
        
        
        //ASSIGNMENT 1 EDIT ABOVE THIS LINE

        //Create Neighbors
        foreach (KeyValuePair<string, GraphNode> kvp in nodeDictionary)
        {
            //Left
            if (nodeDictionary.ContainsKey((kvp.Value.Location + (Vector3.left * gridSize)).ToString()))
            {
                kvp.Value.AddNeighbor(nodeDictionary[(kvp.Value.Location + (Vector3.left * gridSize)).ToString()]);
            }
            //Right
            if (nodeDictionary.ContainsKey((kvp.Value.Location + (Vector3.right * gridSize)).ToString()))
            {
                kvp.Value.AddNeighbor(nodeDictionary[(kvp.Value.Location + (Vector3.right * gridSize)).ToString()]);
            }
            //Up
            if (nodeDictionary.ContainsKey((kvp.Value.Location + (Vector3.up * gridSize)).ToString()))
            {
                kvp.Value.AddNeighbor(nodeDictionary[(kvp.Value.Location + (Vector3.up * gridSize)).ToString()]);
            }
            //Down
            if (nodeDictionary.ContainsKey((kvp.Value.Location + (Vector3.down * gridSize)).ToString()))
            {
                kvp.Value.AddNeighbor(nodeDictionary[(kvp.Value.Location + (Vector3.down * gridSize)).ToString()]);
            }
        }
    }

    public override void VisualizeNodes()
    {
        //Visualize grid points
        foreach (KeyValuePair<string, GraphNode> kvp in nodeDictionary)
        {
            //Draw left line
            Debug.DrawLine(kvp.Value.Location + Vector3.left * gridSize / 2f + Vector3.up * gridSize / 2f, kvp.Value.Location + Vector3.left * gridSize / 2f + Vector3.down * gridSize / 2f, Color.white);
            //Draw right line
            Debug.DrawLine(kvp.Value.Location + Vector3.right * gridSize / 2f + Vector3.up * gridSize / 2f, kvp.Value.Location + Vector3.right * gridSize / 2f + Vector3.down * gridSize / 2f, Color.white);
            //Draw top line
            Debug.DrawLine(kvp.Value.Location + Vector3.up * gridSize / 2f + Vector3.left * gridSize / 2f, kvp.Value.Location + Vector3.up * gridSize / 2f + Vector3.right * gridSize / 2f, Color.white);
            //Draw bottom line
            Debug.DrawLine(kvp.Value.Location + Vector3.down * gridSize / 2f + Vector3.left * gridSize / 2f, kvp.Value.Location + Vector3.down * gridSize / 2f + Vector3.right * gridSize / 2f, Color.white);
        }
    }

    //Find closest node (used for pathing)
    public override GraphNode ClosestNode(Vector3 position)
    {
        float minDist = 1000;
        GraphNode closest = null;
        foreach (KeyValuePair<string, GraphNode> kvp in nodeDictionary)
        {
            float dist = (kvp.Value.Location - position).sqrMagnitude;
            if (dist < minDist)
            {
                minDist = dist;
                closest = kvp.Value;
            }
        }
        return closest;
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PatrolState : State
{
    // Start is called before the first frame update
    private Vector3 TopLeftVector = new Vector3(-1 * ObstacleHandler.Instance.XBound + 1, 1 * ObstacleHandler.Instance.YBound - 1);
    private Vector3 TopRightVector = new Vector3(1 * ObstacleHandler.Instance.XBound - 1, 1 * ObstacleHandler.Instance.YBound - 1);
    private Vector3 BottomRightVector = new Vector3(1 * ObstacleHandler.Instance.XBound - 1, -1 * ObstacleHandler.Instance.YBound + 1);
    private Vector3 BottomLeftVector = new Vector3(-1 * ObstacleHandler.Instance.XBound + 1, -1 * ObstacleHandler.Instance.YBound + 1);
    private int corner = 1;

    public PatrolState() : base("Patrol") { }

    public override void EnterState(FSMAgent agent)
    {
        agent.SetTimer(5f);
    }

    public override void ExitState(FSMAgent agent)
    {
        base.ExitState(agent);
    }

    void Start()
    {
        
    }

    // Update is called once per frame
    public override State Update(FSMAgent agent)
    {
        agent.SetSpeedModifierDouble();
        if (agent.TimerComplete())
        {
            return new GetCloseState();
        }

        if (corner == 1)
        {
            agent.SetTarget(TopLeftVector);
            if (agent.GetPosition() == TopLeftVector)
            {
                corner = 2;
            }
        }
        else if (corner == 2)
        {
            agent.SetTarget(TopRightVector);
            if (agent.GetPosition() == TopRightVector)
            {
                corner = 3;
            }
        }
        else if (corner == 3)
        {
            agent.SetTarget(BottomRightVector);
            if (agent.GetPosition() == BottomRightVector)
            {
                corner = 4;
            }
        }
        else if (corner == 4)
        {
            agent.SetTarget(BottomLeftVector);
            if (agent.GetPosition() == BottomLeftVector)
            {
                corner = 1;
            }
        }
        
        return this;
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GetCloseState : State
{
    //Set name of this state
    public GetCloseState() : base("GetClose") { }

    public override State Update(FSMAgent agent)
    {
        //Handle Following Pacman
        if (agent.TimerComplete())
        {
            return new HuntState();
        }

        Vector3 pacmanLocation = PacmanInfo.Instance.transform.position;

        if (Vector3.Distance(agent.GetPosition(), pacmanLocation) > 0.5)
        {
            Debug.Log("HAH");
            agent.SetTarget(pacmanLocation * 0.8f);
        }
        else
        {
            agent.SetTarget(pacmanLocation * -0.8f);
        }

        //Stay in this state
        return this;
    }

    //Upon entering state, set timer to enter Scatter State
    public override void EnterState(FSMAgent agent)
    {
        agent.SetTimer(3f);
    }

    public override void ExitState(FSMAgent agent) { }
}

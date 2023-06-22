using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClydeState : State
{

    public ClydeState() : base("Clyde") { }

    public override void EnterState(FSMAgent agent)
    {
        agent.SetTimer(20f);
    }

    public override void ExitState(FSMAgent agent)
    {
        base.ExitState(agent);
    }

    public override State Update(FSMAgent agent)
    {
        //Handle Following Pacman
        Vector3 pacmanLocation = PacmanInfo.Instance.transform.position;
        if (agent.CloseEnough(pacmanLocation))
        {
            ScoreHandler.Instance.KillPacman();
        }

        //If Pacman ate a power pellet, go to Frightened State
        if (PelletHandler.Instance.JustEatenPowerPellet)
        {
            return new FrightenedState(this);
        }
        //Change target position
        Vector3 clydePosition = agent.GetPosition();
        float distanceBetweenPacAndClyde = Vector3.Distance(clydePosition, pacmanLocation);
        Debug.Log(distanceBetweenPacAndClyde);
        agent.SetTarget(pacmanLocation);
        if ((distanceBetweenPacAndClyde <= 0.2f*8) || (agent.TimerComplete())) 
        {
            return new ScatterState(new Vector3(ObstacleHandler.Instance.XBound * (-1), ObstacleHandler.Instance.YBound * (-1)), this);
        }

        //Stay in this state
        return this;
    }
}

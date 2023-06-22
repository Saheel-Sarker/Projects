using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PinkyState : State
{

    public PinkyState() : base("Pinky") { }

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

        //If timer complete, go to Scatter State
        if (agent.TimerComplete())
        {
            //change needed here
            return new ScatterState(new Vector3(ObstacleHandler.Instance.XBound*(-1), ObstacleHandler.Instance.YBound), this);
        }

        //If Pacman ate a power pellet, go to Frightened State
        if (PelletHandler.Instance.JustEatenPowerPellet)
        {
            return new FrightenedState(this);
        }
        //Change needed 
        //4*(1/5)=0.8
        pacmanLocation = pacmanLocation + 4 * PacmanInfo.Instance.Facing / 5;
        agent.SetTarget(pacmanLocation);

        //Stay in this state
        return this;
    }
}

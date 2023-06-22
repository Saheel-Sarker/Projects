using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HuntState : State
{
    //Set name of this state
    public HuntState() : base("Hunt") { }

    public override State Update(FSMAgent agent)
    {
        //Handle Following Pacman
        Vector3 pacmanLocation = PacmanInfo.Instance.transform.position;
        agent.SetSpeedModifierDouble();
        if (agent.CloseEnough(pacmanLocation))
        {
            ScoreHandler.Instance.KillPacman();
        }

        //If Pacman ate a power pellet, go to Frightened State
        if (PelletHandler.Instance.JustEatenPowerPellet)
        {
           // kite state
        }
        //If we didn't return follow Pacman
        agent.SetTarget(pacmanLocation);

        //Stay in this state
        return this;
    }

    //Upon entering state, set timer to enter Scatter State
    public override void EnterState(FSMAgent agent)
    {

    }

    public override void ExitState(FSMAgent agent) { }
}

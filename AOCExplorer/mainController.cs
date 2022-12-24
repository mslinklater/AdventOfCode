using Godot;
using System;

public class mainController : Node2D
{
	private HSplitContainer projectBrowserHSplitContainer;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		projectBrowserHSplitContainer = GetNode<HSplitContainer>("CanvasLayer/ProjectBrowserHSplitContainer");
		GD.Print("Hello from C-Sharp");
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }

	public void OnProjectBrowserButtonPressed()
	{
		projectBrowserHSplitContainer.Collapsed = !projectBrowserHSplitContainer.Collapsed;
	}

}

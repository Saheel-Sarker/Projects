import cx_Freeze

executables = [cx_Freeze.Executable("main.py")]

cx_Freeze.setup(
    name="Memory Game",
    options={"build_exe": {"packages":["pygame"],
                           "include_files":["../Memory/images/image0.bmp", "../Memory/images/image1.bmp","../Memory/images/image2.bmp","../Memory/images/image3.bmp","../Memory/images/image4.bmp","../Memory/images/image5.bmp","../Memory/images/image6.bmp","../Memory/images/image7.bmp","../Memory/images/image8.bmp",]}},
    executables = executables

    )
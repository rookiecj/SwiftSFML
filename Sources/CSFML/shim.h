//
// Created by travis on 10/5/20.
//

#ifndef SFMLAPP_SHIM_H
#define SFMLAPP_SHIM_H
#ifdef __APPLE__
#include "/usr/local/include/SFML/Audio.h"
#include "/usr/local/include/SFML/Graphics.h"
#include "/usr/local/include/SFML/Network.h"
#include "/usr/local/include/SFML/OpenGL.h"
#include "/usr/local/include/SFML/System.h"
#include "/usr/local/include/SFML/Window.h"
#else
#include <SFML/Audio.h>
#include <SFML/Graphics.h>
#include <SFML/Network.h>
#include <SFML/OpenGL.h>
#include <SFML/System.h>
#include <SFML/Window.h>
#endif
#endif //SFMLAPP_SHIM_H

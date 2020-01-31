


#include <stdio.h>
#include "FreeRtos.h"
#include "task.h"

TaskHandle_t myTask1Handle = NULL;


void myTask1 (void *p){
    int count = (int*) p;
    while(1){
        printf("hello world!" :d\r\n", count++);
        vTaskDelay(1000); //number of c
        
        if(count == 30){
         VTaskDelete(myTask1Handle);   
        }
        }
    }
}

int main(void)
{
    //passes 25 into task1
    int pass = 25;
    xTaskCreate(myTask1, "task1", 200, (void*) pass, tskIDLE_PRIORITY, &myTask1Handle );
    VTaskStartScheduler();

    return 0;
}

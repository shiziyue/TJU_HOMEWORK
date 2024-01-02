#include <stdio.h>
#include <stdlib.h>

#define MAX_0 3005 //用MAX_0表示无穷

extern struct rtpkt {
  int src_id;       /* id of sending router sending this pkt */
  int dst_id;         /* id of router to which pkt being sent 
                         (must be an immediate neighbor) */
  int mincost[4];    /* min cost to node 0 ... 3 */
  };

extern int TRACE;
extern int YES;
extern int NO;

struct distance_table 
{
  int costs[4][4];//costs[des][via]
} dt0;


/* students to write the following two routines, and maybe some others */

const int neighbor_node0[3] = {1, 2, 3};//邻节点
int connectcosts0[4] = {0, 1, 3, 7}; //节点0到其它节点的最小费用c(0,i)

void rtinit0() 
{
  printf("\nNode0 开始初始化\n");

  //初始化DV表
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      dt0.costs[i][j] = MAX_0;
  
  for (int i = 0; i < 4; i++)
    dt0.costs[i][0] = connectcosts0[i];

  //将初始的DV广播给邻居
	for(int i = 0; i < sizeof(neighbor_node0)/4; i++)
	{
    int src_id = 0;
    int des_id = neighbor_node0[i];
    struct rtpkt init_pkt;

    creatertpkt(&init_pkt, src_id, des_id, connectcosts0); //打包数据
    tolayer2(init_pkt); //将数据传递到链路层，框架会进行链路层的处理

		printf("Node0已将初始的DV{%d,%d,%d,%d}广播给Node%d\n", connectcosts0[0], 
      connectcosts0[1], connectcosts0[2], connectcosts0[3], init_pkt.dst_id);
	}
	printf("完成Node0的初始化\n\n"); 
}


void rtupdate0(rcvdpkt)
  struct rtpkt *rcvdpkt;

{
  //解析收到的数据包
  int src_id = rcvdpkt->src_id;
  int des_id = rcvdpkt->dst_id;
  int *rcvd_cost = rcvdpkt->mincost;//邻居发来的DV
  
  printf("Node0 正在更新\n");

  //如果源ID错误
  if(src_id>4 || src_id<=0)
  {
		printf("源ID错误：接收到从Node%d发来的数据包\n", src_id);
		return;
	}

  //如果目的ID错误
  if (des_id != 0)
  {
    printf("目的ID错误：接收到发给Node%d的数据包\n", des_id);
    return;
  }

  //重新计算DV表
  int temp;
  int self = 0;//自己的节点号
  int update_flag = 0;//DV表更新标志
	for (int i = 0; i < 4; i++)
	{
		//D(self,i) = c(self,src_id)+D(src_id, i)
		temp = dt0.costs[src_id][self] + rcvd_cost[i];

		//保证最大值都为MAX
		if (temp > MAX_0) temp = MAX_0; 

		//如果self到i的费用改变了
		if (temp != dt0.costs[i][src_id])
		{
			dt0.costs[i][src_id] = temp;
			//如果找到通过src_id到i的更小费用路径
			if (temp < mincosts_node0[i])
			{
				mincosts_node0[i] = temp;
				update_flag = 1;
			}
			//如果修改后的费用等于最小费用
			else if (dt0.costs[i][src_id] == mincosts_node0[i])
			{
				//找到费用最低的邻居
				int min = MAX_0;
				for (int j = 0; j < 4; j++)
					if (dt0.costs[i][j] < min)
						min = dt0.costs[i][j];
				mincosts_node0[i] = min;
				update_flag = 1;
			}
		}
	}
  
  //若DV发生改变，则打印新的DV表，并广播邻居
  if (update_flag)
  {
    //打印新的DV表
    printf("Node0 更新后的DV表：\n");
    printdt0(&dt0); //实验框架提供的"beautiful print"
    
    //将新的DV广播给邻居
    for(int i = 0; i < sizeof(neighbor_node0)/4; i++)
    {
      int src_id = 0;
      int des_id = neighbor_node0[i];
      struct rtpkt init_pkt;

      creatertpkt(&init_pkt, src_id, des_id, mincosts_node0); //打包数据
      tolayer2(init_pkt); //将数据传递到链路层，框架会进行链路层的处理

      printf("Node0已将更新后的DV{%d,%d,%d,%d}广播给Node%d\n", mincosts_node0[0], 
        mincosts_node0[1], mincosts_node0[2], mincosts_node0[3], init_pkt.dst_id);
    }
  }

  //若DV未发生改变
  else
  {
    printf("Node0未发生改变\n");
    printdt0(&dt0); //实验框架提供的"beautiful print"
  }
  
  printf("完成Node0的更新\n\n");
}


printdt0(dtptr)
  struct distance_table *dtptr;
  
{
  printf("                via     \n");
  printf("   D0 |    1     2    3 \n");
  printf("  ----|-----------------\n");
  printf("     1|  %3d   %3d   %3d\n",dtptr->costs[1][1],
	 dtptr->costs[1][2],dtptr->costs[1][3]);
  printf("dest 2|  %3d   %3d   %3d\n",dtptr->costs[2][1],
	 dtptr->costs[2][2],dtptr->costs[2][3]);
  printf("     3|  %3d   %3d   %3d\n",dtptr->costs[3][1],
	 dtptr->costs[3][2],dtptr->costs[3][3]);
}


linkhandler0(linkid, newcost)   
  int linkid, newcost;
/* called when cost from 0 to linkid changes from current value to newcost*/
/* You can leave this routine empty if you're an undergrad. If you want */
/* to use this routine, you'll need to change the value of the LINKCHANGE */
/* constant definition in prog3.c from 0 to 1 */

{
}


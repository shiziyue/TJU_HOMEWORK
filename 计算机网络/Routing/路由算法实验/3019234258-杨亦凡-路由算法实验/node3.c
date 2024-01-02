#include <stdio.h>
#include <stdlib.h>

#define MAX_3 3005 //用MAX_3表示无穷

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
} dt3;


/* students to write the following two routines, and maybe some others */

const int neighbor_node3[2] = {0, 2};//邻节点
int mincosts_node3[4] = {7, MAX_3, 2, 0}; //节点3到其它节点的最小费用c(3,i)

void rtinit3() 
{
  printf("Node3 开始初始化\n");

  //初始化DV表
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      dt3.costs[i][j] = MAX_3;
  
  for (int i = 0; i < 4; i++)
    dt3.costs[i][3] = mincosts_node3[i];

  //将初始的DV广播给邻居
	for(int i = 0; i < sizeof(neighbor_node3)/4; i++)
	{
    int src_id = 3;
    int des_id = neighbor_node3[i];
    struct rtpkt init_pkt;

    creatertpkt(&init_pkt, src_id, des_id, mincosts_node3); //打包数据
    tolayer2(init_pkt); //将数据传递到链路层，框架会进行链路层的处理
		printf("Node3已将初始的DV{%d,%d,%d,%d}广播给Node%d\n", mincosts_node3[0], 
      mincosts_node3[1], mincosts_node3[2], mincosts_node3[3], init_pkt.dst_id);
	}
	printf("完成Node3的初始化\n\n"); 
}


void rtupdate3(rcvdpkt)
  struct rtpkt *rcvdpkt;

{
  //解析收到的数据包
  int src_id = rcvdpkt->src_id;
  int des_id = rcvdpkt->dst_id;
  int *rcvd_cost = rcvdpkt->mincost;//邻居发来的DV
  
  printf("Node3正在更新\n");

  //如果源ID错误
  if(src_id>4 || src_id<0 || src_id==3)
  {
		printf("源ID错误：接收到从Node%d发来的数据包\n", src_id);
		return;
	}

  //如果目的ID错误
  if (des_id != 3)
  {
    printf("目的ID错误：接收到发给Node%d的数据包\n", des_id);
    return;
  }

  //重新计算DV表
  int temp;
  int self = 3;//自己的节点号
  int update_flag = 0;//DV表更新标志
	for (int i = 0; i < 4; i++)
	{
		//D(self,i) = c(self,src_id)+D(src_id, i)
		temp = dt3.costs[src_id][self] + rcvd_cost[i];//costs[destination][via]

		//保证最大值都为MAX
		if (temp > MAX_3) temp = MAX_3; 

		//如果self到i的费用改变了
		if (temp != dt3.costs[i][src_id])
		{
			dt3.costs[i][src_id] = temp;
			//如果找到通过src_id到i的更小费用路径
			if (temp < mincosts_node3[i])
			{
				mincosts_node3[i] = temp;
				update_flag = 1;
			}
			//如果修改后的费用等于最小费用
			else if (dt3.costs[i][src_id] == mincosts_node3[i])
			{
				//找到一条路径，使得到邻居的费用最小
				int min = MAX_3;
				for (int j = 0; j < 4; j++)
					if (dt3.costs[i][j] < min)
						min = dt3.costs[i][j];
				mincosts_node3[i] = min;
				update_flag = 1;
			}
		}
	}
  
  if (update_flag)
  {
    //打印新的DV表
    printf("Node3 更新后的DV表：\n");
    printdt3(&dt3); //实验框架提供的"beautiful print"

    //若DV发生改变，则打印新的DV表，并广播邻居
    for(int i = 0; i < sizeof(neighbor_node3)/4; i++)
    {
      int src_id = 3;
      int des_id = neighbor_node3[i];
      struct rtpkt init_pkt;

      creatertpkt(&init_pkt, src_id, des_id, mincosts_node3); //打包数据
      tolayer2(init_pkt); //将数据传递到链路层，框架会进行链路层的处理
      printf("Node3已将更新后的DV{%d,%d,%d,%d}广播给Node%d\n", mincosts_node3[0], 
        mincosts_node3[1], mincosts_node3[2], mincosts_node3[3], init_pkt.dst_id);
    }
  }


  //若DV未发生改变
  else
  {
    printf("Node3未发生改变\n");
    printdt3(&dt3); //实验框架提供的"beautiful print"
  }
  
  printf("完成Node3的更新\n\n");
}


printdt3(dtptr)
  struct distance_table *dtptr;
  
{
  printf("             via     \n");
  printf("   D3 |    0     2 \n");
  printf("  ----|-----------\n");
  printf("     0|  %3d   %3d\n",dtptr->costs[0][0], dtptr->costs[0][2]);
  printf("dest 1|  %3d   %3d\n",dtptr->costs[1][0], dtptr->costs[1][2]);
  printf("     2|  %3d   %3d\n",dtptr->costs[2][0], dtptr->costs[2][2]);

}


linkhandler3(linkid, newcost)   
int linkid, newcost;   
/* called when cost from 3 to linkid changes from current value to newcost*/
/* You can leave this routine empty if you're an undergrad. If you want */
/* to use this routine, you'll need to change the value of the LINKCHANGE */
/* constant definition in prog3.c from 0 to 1 */

{
}


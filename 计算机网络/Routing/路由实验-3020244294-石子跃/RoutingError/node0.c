#include <stdio.h>

extern struct rtpkt {
	int sourceid;       /* id of sending router sending this pkt */
	int destid;         /* id of router to which pkt being sent
                         (must be an immediate neighbor) */
	int mincost[4];    /* min cost to node 0 ... 3 */
};

extern int TRACE;
extern int YES;
extern int NO;

struct distance_table {
	int costs[4][4];
} dt0;


/* students to write the following two routines, and maybe some others */


#define INFINITY 999
#define MAX_NODES 4
int connectcosts0[4] = { 0,  1,  3, 7 };

void rtinit0() {
	//以 INFINITY 初始化
	int i;
	int j;
	for ( i = 0; i < MAX_NODES; i++) {
		for (j = 0; j < MAX_NODES; j++) {
			dt0.costs[i][j] = INFINITY;
			if (i == j)
				dt0.costs[i][j] = 0;
		}
	}
	for(i=0; i<MAX_NODES; i++) {
		dt0.costs[0][i] = connectcosts0[i];
	}
	//向所有邻居结点发送距离?量表
	for ( i = 0; i < MAX_NODES; i++) {
		//即除了自身结点(i=nodei)以及不可达结点(距离 INFINAITY)
		if (i != 0 && dt0.costs[0][i] != INFINITY) {
			struct rtpkt node0_pkt;
			creatertpkt(&node0_pkt, 0, i, dt0.costs[0]);
			tolayer2(node0_pkt);
		}
	}
	printf("	初始化node0==rtinit0\n");
	printdt00(&dt0);
}


void rtupdate0(rcvdpkt)
struct rtpkt *rcvdpkt;
{
	int i;
	//先判断接收数据包rcvpkt->destid是否为正确node
	if (rcvdpkt->destid == 0) {
		//使用标志位标记
		int flag = 0;
		//根据接收到路由消息包更新自己的路由表
		for ( i = 0; i < MAX_NODES; i++) {
			dt0.costs[rcvdpkt->sourceid][i] = rcvdpkt->mincost[i];
		}
		//重新计算距离向量
		for (i=0; i<MAX_NODES; i++) {
			int temp = 0;
			temp = dt0.costs[0][rcvdpkt->sourceid]+rcvdpkt->mincost[i];
			//保证最大值都为MAX
			if (temp > INFINITY) temp = INFINITY;
			if(temp<dt0.costs[0][i]) {
				dt0.costs[0][i]=temp;
				flag = 1;
			}
		}
		if(flag) {
			for (i = 0; i < MAX_NODES; i++) {
				//即除了自身结点(i=nodei)以及不可达结点(距离 INFINAITY)
				if (i != 0 && dt0.costs[0][i] != INFINITY) {
					struct rtpkt node0_pkt;
					creatertpkt(&node0_pkt, 0, i, dt0.costs[0]);
					tolayer2(node0_pkt);
				}
			}
			printf("	更新node0==rtupdate0\n");
			printdt00(&dt0);
		} 
		else {
			printf("	未改变node0==rtupdate0\n");
			printdt00(&dt0);
		}
	}
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

printdt00(dtptr)
struct distance_table *dtptr;

{
	printf("             dest   \n");
	printf("   D0 |    0    1     2    3 \n");
	printf("  ----|----------------------\n");
	printf("     0|  %3d   %3d   %3d   %3d\n",dtptr->costs[0][0],dtptr->costs[0][1],
	       dtptr->costs[0][2],dtptr->costs[0][3]);
	printf("     1|  %3d   %3d   %3d   %3d\n",dtptr->costs[1][0],dtptr->costs[1][1],
	       dtptr->costs[1][2],dtptr->costs[1][3]);
	printf("var  2|  %3d   %3d   %3d   %3d\n",dtptr->costs[2][0],dtptr->costs[2][1],
	       dtptr->costs[2][2],dtptr->costs[2][3]);
	printf("     3|  %3d   %3d   %3d   %3d\n",dtptr->costs[3][0],dtptr->costs[3][1],
	       dtptr->costs[3][2],dtptr->costs[3][3]);
	printf("\n"); 
}

linkhandler0(linkid, newcost)
int linkid, newcost;

/* called when cost from 0 to linkid changes from current value to newcost*/
/* You can leave this routine empty if you're an undergrad. If you want */
/* to use this routine, you'll need to change the value of the LINKCHANGE */
/* constant definition in prog3.c from 0 to 1 */

{
}

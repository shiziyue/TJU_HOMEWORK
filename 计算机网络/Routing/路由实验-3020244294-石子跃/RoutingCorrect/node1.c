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
} dt1;


/* students to write the following two routines, and maybe some others */
#define INFINITY 999
#define MAX_NODES 4
int connectcosts1[4] = { 1,  0,  1, 999 };
rtinit1() {
//以 INFINITY 初始化
	int i;
	int j;
	for ( i = 0; i < MAX_NODES; i++) {
		for (j = 0; j < MAX_NODES; j++) {
			dt1.costs[i][j] = INFINITY;
			if (i == j)
				dt1.costs[i][j] = 0;
		}
	}
	for(i=0; i<MAX_NODES; i++) {
		dt1.costs[i][1] = connectcosts1[i];
	}
	//向所有邻居结点发送距离?量表
	for ( i = 0; i < MAX_NODES; i++) {
		//即除了自身结点(i=nodei)以及不可达结点(距离 INFINAITY)
		if (i != 1 && dt1.costs[i][1] != INFINITY) {
			struct rtpkt node1_pkt;
			creatertpkt(&node1_pkt, 1, i, connectcosts1);
			tolayer2(node1_pkt);
		}
	}
	printf("	初始化node1==rtinit1\n");
	printdt1(&dt1);
}


rtupdate1(rcvdpkt)
struct rtpkt *rcvdpkt;

{
	int i;
	//先判断接收数据包rcvpkt->destid是否为正确node
	if (rcvdpkt->destid == 1) {
		//使用标志位标记
		int flag = 0;
		//重新计算距离向量
		for (i=0; i<MAX_NODES; i++) {
			int temp = 0;
			temp = dt1.costs[rcvdpkt->sourceid][1]+rcvdpkt->mincost[i];
			//保证最大值都为MAX
			if (temp > INFINITY) temp = INFINITY;
			//如果发生改变就将现在矢量表替换更新 
			if(temp!=dt1.costs[i][rcvdpkt->sourceid]) {
				dt1.costs[i][rcvdpkt->sourceid]=temp;
				//如果距离变小，则更新目前到的节点距离最小的集合 
				if(temp<connectcosts1[i]) {
					connectcosts1[i]=temp;
					flag = 1;
				}
			}
		}
		if(flag) {
			for ( i = 0; i < MAX_NODES; i++) {
				//即除了自身结点(i=nodei)以及不可达结点(距离 INFINAITY)
				if (i != 1 && dt1.costs[i][1] != INFINITY) {
					struct rtpkt node1_pkt;
					creatertpkt(&node1_pkt, 1, i, connectcosts1);
					tolayer2(node1_pkt);
				}
			}
			//打印更新后的表 
			printf("	更新node1==rtupdate1\n");
			printdt1(&dt1);
		} else {
			printf("	未改变node1==rtupdate1\n");
			printdt1(&dt1);
		}
	}
}


printdt1(dtptr)
struct distance_table *dtptr;

{
	printf("             via   \n");
	printf("   D1 |    0     2 \n");
	printf("  ----|-----------\n");
	printf("     0|  %3d   %3d\n",dtptr->costs[0][0], dtptr->costs[0][2]);
	printf("dest 2|  %3d   %3d\n",dtptr->costs[2][0], dtptr->costs[2][2]);
	printf("     3|  %3d   %3d\n",dtptr->costs[3][0], dtptr->costs[3][2]);

}



linkhandler1(linkid, newcost)
int linkid, newcost;
/* called when cost from 1 to linkid changes from current value to newcost*/
/* You can leave this routine empty if you're an undergrad. If you want */
/* to use this routine, you'll need to change the value of the LINKCHANGE */
/* constant definition in prog3.c from 0 to 1 */

{
}


#include<cstring>
using namespace std;
const int maxn=203;

struct jiedian
{
  int n,dao[maxn];
};
		
int n,m,zuo[maxn],i,j,duiz[maxn],duiy[maxn],nn,t,rr=0;
jiedian dian[maxn];
bool yong[maxn];
/*zuo ���ı��,һ����1-n�� duiz,duiy�ֱ������ߵ�ƥ��,
rrΪ���ƥ��,dian��¼����������Ϣ */
bool xiong(int x)
{
  int i,tt;
//����ĵ㶼�����
  for (i=1;i<=dian[x].n;i++)//�������������ҵ�
  {
    tt=dian[x].dao[i];
    if ((!yong[tt])&&(duiy[tt]!=x))//δ�ظ�������û�кʹ˵�ƥ�䣨��֤����1
    {
      yong[tt]=true;
      if ((!duiy[tt])||xiong(duiy[tt]))//�����δƥ��㣬����Ϊ�յ㣬����˳����ƥ������������죨��֤����2��������ҵ���
      {
        duiz[x]=tt;
        duiy[tt]=x;//�������ң�����ԭƥ��ı��Զ�ɾ��
        return true;
      }
    }
  }
  return false;
}

int main()
{
  for (i=1;i<=nn;i++)
  {
    t=zuo[i];
    if (!duiz[t])
    {
      memset(yong,0,sizeof(yong));
      if (xiong(t))//�ҵ������
        rr++;//ƥ����+1
    }
  }
  ouf<<rr<<endl;
}

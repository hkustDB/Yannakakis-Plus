## AggReduce Phase: 

# AggReduce42
# 1. aggView
create or replace view aggView361463789764932236 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4798683975195789984 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView361463789764932236 where Person_likes_Message.MessageId=aggView361463789764932236.v1;

# AggReduce43
# 1. aggView
create or replace view aggView3029258133719152549 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin4363057434720029863 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3029258133719152549 where Message_hasCreator_Person.MessageId=aggView3029258133719152549.v1;

# AggReduce44
# 1. aggView
create or replace view aggView1770801988472641986 as select v1, SUM(annot) as annot from aggJoin4363057434720029863 group by v1;
# 2. aggJoin
create or replace view aggJoin2358057061658186622 as select aggJoin4798683975195789984.annot * aggView1770801988472641986.annot as annot from aggJoin4798683975195789984 join aggView1770801988472641986 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin2358057061658186622;

# drop view aggView361463789764932236, aggJoin4798683975195789984, aggView3029258133719152549, aggJoin4363057434720029863, aggView1770801988472641986, aggJoin2358057061658186622;

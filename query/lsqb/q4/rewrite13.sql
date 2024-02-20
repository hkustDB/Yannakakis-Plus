## AggReduce Phase: 

# AggReduce39
# 1. aggView
create or replace view aggView8364929223346477519 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin2096518408511117788 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8364929223346477519 where Comment_replyOf_Message.ParentMessageId=aggView8364929223346477519.v1;

# AggReduce40
# 1. aggView
create or replace view aggView3794423587502219170 as select v1, SUM(annot) as annot from aggJoin2096518408511117788 group by v1;
# 2. aggJoin
create or replace view aggJoin381075479707988965 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3794423587502219170 where Person_likes_Message.MessageId=aggView3794423587502219170.v1;

# AggReduce41
# 1. aggView
create or replace view aggView731680021637152670 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin6471417645172742112 as select aggJoin381075479707988965.annot * aggView731680021637152670.annot as annot from aggJoin381075479707988965 join aggView731680021637152670 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin6471417645172742112;

# drop view aggView8364929223346477519, aggJoin2096518408511117788, aggView3794423587502219170, aggJoin381075479707988965, aggView731680021637152670, aggJoin6471417645172742112;

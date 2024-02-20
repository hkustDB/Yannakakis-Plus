## AggReduce Phase: 

# AggReduce132
# 1. aggView
create or replace view aggView8857819528138961451 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin8834129011612842986 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8857819528138961451 where Comment_replyOf_Message.ParentMessageId=aggView8857819528138961451.v1;

# AggReduce133
# 1. aggView
create or replace view aggView6656794665454057794 as select v1, SUM(annot) as annot from aggJoin8834129011612842986 group by v1;
# 2. aggJoin
create or replace view aggJoin2709342970102213298 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView6656794665454057794 where Person_likes_Message.MessageId=aggView6656794665454057794.v1;

# AggReduce134
# 1. aggView
create or replace view aggView388007815758622 as select v1, SUM(annot) as annot from aggJoin2709342970102213298 group by v1;
# 2. aggJoin
create or replace view aggJoin1565427224510478130 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView388007815758622 where Message_hasCreator_Person.MessageId=aggView388007815758622.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1565427224510478130;

# drop view aggView8857819528138961451, aggJoin8834129011612842986, aggView6656794665454057794, aggJoin2709342970102213298, aggView388007815758622, aggJoin1565427224510478130;

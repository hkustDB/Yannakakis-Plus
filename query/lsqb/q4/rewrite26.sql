## AggReduce Phase: 

# AggReduce78
# 1. aggView
create or replace view aggView1041101587350094135 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin6669874184072442632 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1041101587350094135 where Message_hasCreator_Person.MessageId=aggView1041101587350094135.v1;

# AggReduce79
# 1. aggView
create or replace view aggView6533633375376518039 as select v1, SUM(annot) as annot from aggJoin6669874184072442632 group by v1;
# 2. aggJoin
create or replace view aggJoin3455072249506263593 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6533633375376518039 where Comment_replyOf_Message.ParentMessageId=aggView6533633375376518039.v1;

# AggReduce80
# 1. aggView
create or replace view aggView8536452732606345240 as select v1, SUM(annot) as annot from aggJoin3455072249506263593 group by v1;
# 2. aggJoin
create or replace view aggJoin5044294085549824995 as select annot from Person_likes_Message as Person_likes_Message, aggView8536452732606345240 where Person_likes_Message.MessageId=aggView8536452732606345240.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5044294085549824995;

# drop view aggView1041101587350094135, aggJoin6669874184072442632, aggView6533633375376518039, aggJoin3455072249506263593, aggView8536452732606345240, aggJoin5044294085549824995;

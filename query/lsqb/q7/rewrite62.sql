## AggReduce Phase: 

# AggReduce186
# 1. aggView
create or replace view aggView4232592848574420358 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin6143696671911432364 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4232592848574420358 where Person_likes_Message.MessageId=aggView4232592848574420358.v1;

# AggReduce187
# 1. aggView
create or replace view aggView7184747601750774491 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin3917956665906236464 as select v1, aggJoin6143696671911432364.annot * aggView7184747601750774491.annot as annot from aggJoin6143696671911432364 join aggView7184747601750774491 using(v1);

# AggReduce188
# 1. aggView
create or replace view aggView1559095960801305846 as select v1, SUM(annot) as annot from aggJoin3917956665906236464 group by v1;
# 2. aggJoin
create or replace view aggJoin5134858746919934366 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1559095960801305846 where Message_hasCreator_Person.MessageId=aggView1559095960801305846.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5134858746919934366;

# drop view aggView4232592848574420358, aggJoin6143696671911432364, aggView7184747601750774491, aggJoin3917956665906236464, aggView1559095960801305846, aggJoin5134858746919934366;

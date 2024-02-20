## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView5223346348000151681 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4894460303085192148 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5223346348000151681 where Comment_replyOf_Message.ParentMessageId=aggView5223346348000151681.v1;

# AggReduce7
# 1. aggView
create or replace view aggView8087342410318005393 as select v1, SUM(annot) as annot from aggJoin4894460303085192148 group by v1;
# 2. aggJoin
create or replace view aggJoin1636385282631173314 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8087342410318005393 where Person_likes_Message.MessageId=aggView8087342410318005393.v1;

# AggReduce8
# 1. aggView
create or replace view aggView4730462380898638879 as select v1, SUM(annot) as annot from aggJoin1636385282631173314 group by v1;
# 2. aggJoin
create or replace view aggJoin4686307346386240541 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4730462380898638879 where Message_hasTag_Tag.MessageId=aggView4730462380898638879.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin4686307346386240541;

# drop view aggView5223346348000151681, aggJoin4894460303085192148, aggView8087342410318005393, aggJoin1636385282631173314, aggView4730462380898638879, aggJoin4686307346386240541;

## AggReduce Phase: 

# AggReduce132
# 1. aggView
create or replace view aggView485695506981786560 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8602795907723214019 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView485695506981786560 where Person_likes_Message.MessageId=aggView485695506981786560.v1;

# AggReduce133
# 1. aggView
create or replace view aggView4388924120606588530 as select v1, SUM(annot) as annot from aggJoin8602795907723214019 group by v1;
# 2. aggJoin
create or replace view aggJoin6297126902140157910 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4388924120606588530 where Comment_replyOf_Message.ParentMessageId=aggView4388924120606588530.v1;

# AggReduce134
# 1. aggView
create or replace view aggView189381649866179938 as select v1, SUM(annot) as annot from aggJoin6297126902140157910 group by v1;
# 2. aggJoin
create or replace view aggJoin830375744448651254 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView189381649866179938 where Message_hasTag_Tag.MessageId=aggView189381649866179938.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin830375744448651254;

# drop view aggView485695506981786560, aggJoin8602795907723214019, aggView4388924120606588530, aggJoin6297126902140157910, aggView189381649866179938, aggJoin830375744448651254;

## AggReduce Phase: 

# AggReduce81
# 1. aggView
create or replace view aggView7091640158545510970 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin2829852262403048596 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7091640158545510970 where Message_hasCreator_Person.MessageId=aggView7091640158545510970.v1;

# AggReduce82
# 1. aggView
create or replace view aggView2495107438118127452 as select v1, SUM(annot) as annot from aggJoin2829852262403048596 group by v1;
# 2. aggJoin
create or replace view aggJoin7995128599887840497 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2495107438118127452 where Message_hasTag_Tag.MessageId=aggView2495107438118127452.v1;

# AggReduce83
# 1. aggView
create or replace view aggView5544147662366655778 as select v1, SUM(annot) as annot from aggJoin7995128599887840497 group by v1;
# 2. aggJoin
create or replace view aggJoin5906063542355710959 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5544147662366655778 where Comment_replyOf_Message.ParentMessageId=aggView5544147662366655778.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5906063542355710959;

# drop view aggView7091640158545510970, aggJoin2829852262403048596, aggView2495107438118127452, aggJoin7995128599887840497, aggView5544147662366655778, aggJoin5906063542355710959;

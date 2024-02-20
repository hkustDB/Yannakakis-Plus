## AggReduce Phase: 

# AggReduce60
# 1. aggView
create or replace view aggView3514192231050751550 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin4464464792480221850 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3514192231050751550 where Message_hasCreator_Person.MessageId=aggView3514192231050751550.v1;

# AggReduce61
# 1. aggView
create or replace view aggView4259810246838063420 as select v1, SUM(annot) as annot from aggJoin4464464792480221850 group by v1;
# 2. aggJoin
create or replace view aggJoin4906867849741956980 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4259810246838063420 where Message_hasTag_Tag.MessageId=aggView4259810246838063420.v1;

# AggReduce62
# 1. aggView
create or replace view aggView2096996495603754267 as select v1, SUM(annot) as annot from aggJoin4906867849741956980 group by v1;
# 2. aggJoin
create or replace view aggJoin475566479123985447 as select annot from Person_likes_Message as Person_likes_Message, aggView2096996495603754267 where Person_likes_Message.MessageId=aggView2096996495603754267.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin475566479123985447;

# drop view aggView3514192231050751550, aggJoin4464464792480221850, aggView4259810246838063420, aggJoin4906867849741956980, aggView2096996495603754267, aggJoin475566479123985447;

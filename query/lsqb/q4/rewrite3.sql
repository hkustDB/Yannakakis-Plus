## AggReduce Phase: 

# AggReduce9
# 1. aggView
create or replace view aggView4669988109360882501 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin8421988494728087841 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4669988109360882501 where Message_hasCreator_Person.MessageId=aggView4669988109360882501.v1;

# AggReduce10
# 1. aggView
create or replace view aggView6996258075367737858 as select v1, SUM(annot) as annot from aggJoin8421988494728087841 group by v1;
# 2. aggJoin
create or replace view aggJoin5380828930533813044 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6996258075367737858 where Message_hasTag_Tag.MessageId=aggView6996258075367737858.v1;

# AggReduce11
# 1. aggView
create or replace view aggView4439266219783966713 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin3197087161597031974 as select aggJoin5380828930533813044.annot * aggView4439266219783966713.annot as annot from aggJoin5380828930533813044 join aggView4439266219783966713 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin3197087161597031974;

# drop view aggView4669988109360882501, aggJoin8421988494728087841, aggView6996258075367737858, aggJoin5380828930533813044, aggView4439266219783966713, aggJoin3197087161597031974;

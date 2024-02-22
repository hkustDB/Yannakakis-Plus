create or replace view aggView1632164219978065295 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin7605836319826102387 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1632164219978065295 where Message_hasTag_Tag.MessageId=aggView1632164219978065295.v1;
create or replace view aggView6363401085592478090 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin4329192224058012600 as select v1, aggJoin7605836319826102387.annot * aggView6363401085592478090.annot as annot from aggJoin7605836319826102387 join aggView6363401085592478090 using(v1);
create or replace view aggView1352165997329396218 as select v1, SUM(annot) as annot from aggJoin4329192224058012600 group by v1;
create or replace view aggJoin4799614095861816332 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1352165997329396218 where Message_hasCreator_Person.MessageId=aggView1352165997329396218.v1;
select SUM(annot) as v9 from aggJoin4799614095861816332;

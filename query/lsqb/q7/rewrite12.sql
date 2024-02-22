create or replace view aggView4817940135560871273 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5299510916977121535 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4817940135560871273 where Message_hasTag_Tag.MessageId=aggView4817940135560871273.v1;
create or replace view aggView2063495495717754493 as select v1, SUM(annot) as annot from aggJoin5299510916977121535 group by v1;
create or replace view aggJoin7450889442113603341 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2063495495717754493 where Person_likes_Message.MessageId=aggView2063495495717754493.v1;
create or replace view aggView2864735645753700486 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin1662218149334985407 as select aggJoin7450889442113603341.annot * aggView2864735645753700486.annot as annot from aggJoin7450889442113603341 join aggView2864735645753700486 using(v1);
select SUM(annot) as v9 from aggJoin1662218149334985407;

create or replace view aggView3478318496818922194 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8409610894125040418 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3478318496818922194 where Message_hasTag_Tag.MessageId=aggView3478318496818922194.v1;
create or replace view aggView8375059320412104862 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5772918514654377562 as select v1, aggJoin8409610894125040418.annot * aggView8375059320412104862.annot as annot from aggJoin8409610894125040418 join aggView8375059320412104862 using(v1);
create or replace view aggView4112796256703704751 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin6368170401523951440 as select aggJoin5772918514654377562.annot * aggView4112796256703704751.annot as annot from aggJoin5772918514654377562 join aggView4112796256703704751 using(v1);
select SUM(annot) as v9 from aggJoin6368170401523951440;

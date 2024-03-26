create or replace view aggView9157564249197386264 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin4330271716794141524 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView9157564249197386264 where mk.movie_id=aggView9157564249197386264.v12;
create or replace view aggView8460391628416395463 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin3995931242381547684 as select v1, v24 as v24 from aggJoin4330271716794141524 join aggView8460391628416395463 using(v12);
create or replace view aggView2796626526856198412 as select v1, MIN(v24) as v24 from aggJoin3995931242381547684 group by v1;
create or replace view aggJoin7843972792423503484 as select keyword as v2, v24 from keyword as k, aggView2796626526856198412 where k.id=aggView2796626526856198412.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin7843972792423503484;

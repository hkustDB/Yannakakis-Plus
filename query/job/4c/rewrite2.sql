create or replace view aggView1585619186397951845 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8052856346478409947 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1585619186397951845 where mi_idx.info_type_id=aggView1585619186397951845.v1 and info>'2.0';
create or replace view aggView6781752241607879588 as select v14, MIN(v9) as v26 from aggJoin8052856346478409947 group by v14;
create or replace view aggJoin1806563697184259782 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView6781752241607879588 where t.id=aggView6781752241607879588.v14 and production_year>1990;
create or replace view aggView7334743822460520372 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin1806563697184259782 group by v14,v26;
create or replace view aggJoin6458219208741692529 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView7334743822460520372 where mk.movie_id=aggView7334743822460520372.v14;
create or replace view aggView779904100810256416 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8039953845545998153 as select v26, v27 from aggJoin6458219208741692529 join aggView779904100810256416 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin8039953845545998153;

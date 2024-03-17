create or replace view aggView7612202057023263769 as select id as v14, name as v36 from name as n;
create or replace view aggJoin8688503769521009074 as select movie_id as v23, v36 from cast_info as ci, aggView7612202057023263769 where ci.person_id=aggView7612202057023263769.v14;
create or replace view aggView6152250068389718701 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7362514059463361089 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView6152250068389718701 where mk.movie_id=aggView6152250068389718701.v23;
create or replace view aggView4904020335471206012 as select v23, MIN(v36) as v36 from aggJoin8688503769521009074 group by v23;
create or replace view aggJoin8221228647527227967 as select v8, v37 as v37, v36 from aggJoin7362514059463361089 join aggView4904020335471206012 using(v23);
create or replace view aggView6837394152593288121 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin8221228647527227967 group by v8;
create or replace view aggJoin1514279012236032752 as select keyword as v9, v37, v36 from keyword as k, aggView6837394152593288121 where k.id=aggView6837394152593288121.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1514279012236032752;

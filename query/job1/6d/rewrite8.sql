create or replace view aggView6024286954520435672 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4445887974845921084 as select movie_id as v23, v35 from movie_keyword as mk, aggView6024286954520435672 where mk.keyword_id=aggView6024286954520435672.v8;
create or replace view aggView1235774098706162068 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3916607684299197688 as select movie_id as v23, v36 from cast_info as ci, aggView1235774098706162068 where ci.person_id=aggView1235774098706162068.v14;
create or replace view aggView9200496291656516863 as select v23, MIN(v35) as v35 from aggJoin4445887974845921084 group by v23,v35;
create or replace view aggJoin6003436071387742540 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView9200496291656516863 where t.id=aggView9200496291656516863.v23 and production_year>2000;
create or replace view aggView2207725081372500525 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6003436071387742540 group by v23,v35;
create or replace view aggJoin9017079588654706305 as select v36 as v36, v35, v37 from aggJoin3916607684299197688 join aggView2207725081372500525 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin9017079588654706305;

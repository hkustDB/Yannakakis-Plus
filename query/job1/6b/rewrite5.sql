create or replace view aggView7320801537379687953 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin2508307641903119248 as select movie_id as v23, v35 from movie_keyword as mk, aggView7320801537379687953 where mk.keyword_id=aggView7320801537379687953.v8;
create or replace view aggView6430765690177007621 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6881718121145588109 as select movie_id as v23, v36 from cast_info as ci, aggView6430765690177007621 where ci.person_id=aggView6430765690177007621.v14;
create or replace view aggView4341931005273098887 as select v23, MIN(v35) as v35 from aggJoin2508307641903119248 group by v23;
create or replace view aggJoin8043572811884070556 as select id as v23, title as v24, v35 from title as t, aggView4341931005273098887 where t.id=aggView4341931005273098887.v23 and production_year>2014;
create or replace view aggView303101876575146432 as select v23, MIN(v36) as v36 from aggJoin6881718121145588109 group by v23;
create or replace view aggJoin2845032560266037975 as select v24, v35 as v35, v36 from aggJoin8043572811884070556 join aggView303101876575146432 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin2845032560266037975;

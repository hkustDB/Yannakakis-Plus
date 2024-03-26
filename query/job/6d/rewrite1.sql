create or replace view aggView2987154371650357490 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7031808850667965707 as select movie_id as v23, v36 from cast_info as ci, aggView2987154371650357490 where ci.person_id=aggView2987154371650357490.v14;
create or replace view aggView39020418302382525 as select v23, MIN(v36) as v36 from aggJoin7031808850667965707 group by v23;
create or replace view aggJoin4497013555828111718 as select id as v23, title as v24, v36 from title as t, aggView39020418302382525 where t.id=aggView39020418302382525.v23 and production_year>2000;
create or replace view aggView5998070698417424161 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin4497013555828111718 group by v23;
create or replace view aggJoin8453059494653426015 as select keyword_id as v8, v36, v37 from movie_keyword as mk, aggView5998070698417424161 where mk.movie_id=aggView5998070698417424161.v23;
create or replace view aggView6734674368544420006 as select v8, MIN(v36) as v36, MIN(v37) as v37 from aggJoin8453059494653426015 group by v8;
create or replace view aggJoin4708767702325760631 as select keyword as v9, v36, v37 from keyword as k, aggView6734674368544420006 where k.id=aggView6734674368544420006.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4708767702325760631;

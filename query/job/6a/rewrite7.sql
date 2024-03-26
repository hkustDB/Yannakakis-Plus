create or replace view aggView978972385863710527 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3709101203434861130 as select movie_id as v23, v36 from cast_info as ci, aggView978972385863710527 where ci.person_id=aggView978972385863710527.v14;
create or replace view aggView2453865407553219605 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5137948110687356683 as select movie_id as v23, v35 from movie_keyword as mk, aggView2453865407553219605 where mk.keyword_id=aggView2453865407553219605.v8;
create or replace view aggView5131510962031549214 as select v23, MIN(v36) as v36 from aggJoin3709101203434861130 group by v23;
create or replace view aggJoin3848109353085916089 as select id as v23, title as v24, v36 from title as t, aggView5131510962031549214 where t.id=aggView5131510962031549214.v23 and production_year>2010;
create or replace view aggView7726255863823366798 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin3848109353085916089 group by v23;
create or replace view aggJoin8222345226946587514 as select v35 as v35, v36, v37 from aggJoin5137948110687356683 join aggView7726255863823366798 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8222345226946587514;

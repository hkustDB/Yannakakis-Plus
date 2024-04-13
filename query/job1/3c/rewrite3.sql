create or replace view aggView6467025988546017886 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9153558481581503323 as select movie_id as v12 from movie_keyword as mk, aggView6467025988546017886 where mk.keyword_id=aggView6467025988546017886.v1;
create or replace view aggView3340277572482525373 as select v12 from aggJoin9153558481581503323 group by v12;
create or replace view aggJoin3694616983700660165 as select id as v12, title as v13, production_year as v16 from title as t, aggView3340277572482525373 where t.id=aggView3340277572482525373.v12 and production_year>1990;
create or replace view aggView2801023037035503031 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin8651409661317358806 as select v13, v16 from aggJoin3694616983700660165 join aggView2801023037035503031 using(v12);
create or replace view aggView8915248692796669145 as select v13 from aggJoin8651409661317358806 group by v13;
select min(v13) as v24 from aggView8915248692796669145;

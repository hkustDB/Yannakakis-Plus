create or replace view aggView2618888986883043852 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin2986987271779319300 as select id as v12, title as v13, production_year as v16 from title as t, aggView2618888986883043852 where t.id=aggView2618888986883043852.v12 and production_year>2005;
create or replace view aggView3295614446772223518 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5959805433859275800 as select movie_id as v12 from movie_keyword as mk, aggView3295614446772223518 where mk.keyword_id=aggView3295614446772223518.v1;
create or replace view aggView3488527550581417592 as select v12, MIN(v13) as v24 from aggJoin2986987271779319300 group by v12;
create or replace view aggJoin720875529577168790 as select v24 from aggJoin5959805433859275800 join aggView3488527550581417592 using(v12);
select MIN(v24) as v24 from aggJoin720875529577168790;

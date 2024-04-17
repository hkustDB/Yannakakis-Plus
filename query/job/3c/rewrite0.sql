create or replace view aggView6601505739171070680 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7852976589364967300 as select movie_id as v12 from movie_keyword as mk, aggView6601505739171070680 where mk.keyword_id=aggView6601505739171070680.v1;
create or replace view aggView8607928828217293850 as select v12 from aggJoin7852976589364967300 group by v12;
create or replace view aggJoin9085054532645818773 as select movie_id as v12, info as v7 from movie_info as mi, aggView8607928828217293850 where mi.movie_id=aggView8607928828217293850.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5744499208254329226 as select v12 from aggJoin9085054532645818773 group by v12;
create or replace view aggJoin3395608486724062624 as select title as v13, production_year as v16 from title as t, aggView5744499208254329226 where t.id=aggView5744499208254329226.v12 and production_year>1990;
create or replace view aggView3391502135481146456 as select v13 from aggJoin3395608486724062624 group by v13;
select MIN(v13) as v24 from aggView3391502135481146456;

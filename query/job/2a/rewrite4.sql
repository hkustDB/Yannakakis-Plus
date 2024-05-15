create or replace view aggView2967013692735134656 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin4117092923376023876 as select movie_id as v12 from movie_companies as mc, aggView2967013692735134656 where mc.company_id=aggView2967013692735134656.v1;
create or replace view aggView9220547378113522753 as select v12 from aggJoin4117092923376023876 group by v12;
create or replace view aggJoin3654090273671911675 as select id as v12, title as v20 from title as t, aggView9220547378113522753 where t.id=aggView9220547378113522753.v12;
create or replace view aggView8114613671591539610 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin2228836644114152131 as select movie_id as v12 from movie_keyword as mk, aggView8114613671591539610 where mk.keyword_id=aggView8114613671591539610.v18;
create or replace view aggView2510134064237641867 as select v12, MIN(v20) as v31 from aggJoin3654090273671911675 group by v12;
create or replace view aggJoin1100725922170839030 as select v31 from aggJoin2228836644114152131 join aggView2510134064237641867 using(v12);
select MIN(v31) as v31 from aggJoin1100725922170839030;

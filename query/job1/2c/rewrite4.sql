create or replace view aggView8652303150704738124 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin6064977760901345304 as select movie_id as v12 from movie_companies as mc, aggView8652303150704738124 where mc.company_id=aggView8652303150704738124.v1;
create or replace view aggView3989413060006570127 as select v12 from aggJoin6064977760901345304 group by v12;
create or replace view aggJoin4393698140673380135 as select id as v12, title as v20 from title as t, aggView3989413060006570127 where t.id=aggView3989413060006570127.v12;
create or replace view aggView2630527133376014266 as select v12, MIN(v20) as v31 from aggJoin4393698140673380135 group by v12;
create or replace view aggJoin9007255472127697762 as select keyword_id as v18, v31 from movie_keyword as mk, aggView2630527133376014266 where mk.movie_id=aggView2630527133376014266.v12;
create or replace view aggView9167979536130789525 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5388037810135161864 as select v31 from aggJoin9007255472127697762 join aggView9167979536130789525 using(v18);
select MIN(v31) as v31 from aggJoin5388037810135161864;

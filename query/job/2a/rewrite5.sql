create or replace view aggView4758682160190016139 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8080767038044316166 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4758682160190016139 where mk.movie_id=aggView4758682160190016139.v12;
create or replace view aggView8290880233943194818 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin2092311777724562190 as select movie_id as v12 from movie_companies as mc, aggView8290880233943194818 where mc.company_id=aggView8290880233943194818.v1;
create or replace view aggView4495531008782049765 as select v12 from aggJoin2092311777724562190 group by v12;
create or replace view aggJoin7853039744718350613 as select v18, v31 as v31 from aggJoin8080767038044316166 join aggView4495531008782049765 using(v12);
create or replace view aggView4681352231904971417 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6880658090114148599 as select v31 from aggJoin7853039744718350613 join aggView4681352231904971417 using(v18);
select MIN(v31) as v31 from aggJoin6880658090114148599;

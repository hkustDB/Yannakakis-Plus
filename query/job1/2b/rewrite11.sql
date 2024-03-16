create or replace view aggView6384535879024867036 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7504487702840906759 as select movie_id as v12 from movie_keyword as mk, aggView6384535879024867036 where mk.keyword_id=aggView6384535879024867036.v18;
create or replace view aggView4178358977960213285 as select v12 from aggJoin7504487702840906759 group by v12;
create or replace view aggJoin1446407100694570770 as select id as v12, title as v20 from title as t, aggView4178358977960213285 where t.id=aggView4178358977960213285.v12;
create or replace view aggView2287460273962536565 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin8579863690360065182 as select movie_id as v12 from movie_companies as mc, aggView2287460273962536565 where mc.company_id=aggView2287460273962536565.v1;
create or replace view aggView9124846996125196541 as select v12 from aggJoin8579863690360065182 group by v12;
create or replace view aggJoin4291957611148235077 as select v20 from aggJoin1446407100694570770 join aggView9124846996125196541 using(v12);
select MIN(v20) as v31 from aggJoin4291957611148235077;

create or replace view aggView5144878167686966320 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin3989548591563288910 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView5144878167686966320 where mc.movie_id=aggView5144878167686966320.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView4086930626545227358 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4522849625033775717 as select v15, v9, v28, v29 from aggJoin3989548591563288910 join aggView4086930626545227358 using(v1);
create or replace view aggView3654738106188238003 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6296054308593174048 as select movie_id as v15 from movie_info_idx as mi_idx, aggView3654738106188238003 where mi_idx.info_type_id=aggView3654738106188238003.v3;
create or replace view aggView3472773530877718450 as select v15 from aggJoin6296054308593174048 group by v15;
create or replace view aggJoin6989459237355668912 as select v9, v28 as v28, v29 as v29 from aggJoin4522849625033775717 join aggView3472773530877718450 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6989459237355668912;

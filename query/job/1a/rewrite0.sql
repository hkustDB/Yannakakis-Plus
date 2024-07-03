create or replace view aggView5444125463151814955 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin3317109740096809620 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5444125463151814955 where mi_idx.info_type_id=aggView5444125463151814955.v3;
create or replace view aggView1677475375120014564 as select v15 from aggJoin3317109740096809620 group by v15;
create or replace view aggJoin6643400305341799612 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView1677475375120014564 where mc.movie_id=aggView1677475375120014564.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView756924113092613098 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin206350773245404905 as select v15, v9 from aggJoin6643400305341799612 join aggView756924113092613098 using(v1);
create or replace view aggView3091575384486404650 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin3281908045188086306 as select v9, v28, v29 from aggJoin206350773245404905 join aggView3091575384486404650 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3281908045188086306;

create or replace view aggView6940375991718927907 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4770284640657105203 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6940375991718927907 where mi_idx.info_type_id=aggView6940375991718927907.v3;
create or replace view aggView4784290771496787326 as select v15 from aggJoin4770284640657105203 group by v15;
create or replace view aggJoin8856403615255568319 as select id as v15, title as v16, production_year as v19 from title as t, aggView4784290771496787326 where t.id=aggView4784290771496787326.v15 and production_year>2000;
create or replace view aggView7256867997304693033 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin8856403615255568319 group by v15;
create or replace view aggJoin8441739897129024637 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7256867997304693033 where mc.movie_id=aggView7256867997304693033.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3459342963264475181 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8830112749581125569 as select v9, v28, v29 from aggJoin8441739897129024637 join aggView3459342963264475181 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8830112749581125569;

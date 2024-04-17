create or replace view aggView7714068624626639901 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin6154895296694874977 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView7714068624626639901 where mi_idx.movie_id=aggView7714068624626639901.v15;
create or replace view aggView172577702122193524 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin5542416577338506677 as select v15, v28, v29 from aggJoin6154895296694874977 join aggView172577702122193524 using(v3);
create or replace view aggView4284263663344716030 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin5542416577338506677 group by v15,v28,v29;
create or replace view aggJoin721308166339674647 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView4284263663344716030 where mc.movie_id=aggView4284263663344716030.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8052393365102908388 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5689271599188752915 as select v9, v28, v29 from aggJoin721308166339674647 join aggView8052393365102908388 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5689271599188752915;

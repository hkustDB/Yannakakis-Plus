create or replace view aggView2950480827531426139 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin4563087245519222952 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2950480827531426139 where mi_idx.movie_id=aggView2950480827531426139.v15;
create or replace view aggView5683051684018660370 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4376944239982943520 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5683051684018660370 where mc.company_type_id=aggView5683051684018660370.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8067080592966646684 as select v15, MIN(v9) as v27 from aggJoin4376944239982943520 group by v15;
create or replace view aggJoin9014981888664082706 as select v3, v28 as v28, v29 as v29, v27 from aggJoin4563087245519222952 join aggView8067080592966646684 using(v15);
create or replace view aggView8383554402397032833 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3536676341238633209 as select v28, v29, v27 from aggJoin9014981888664082706 join aggView8383554402397032833 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3536676341238633209;

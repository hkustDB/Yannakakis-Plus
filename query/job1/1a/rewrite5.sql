create or replace view aggView803684330654251895 as select id as v15, title as v28, production_year as v29 from title as t;
create or replace view aggJoin2877488270420985877 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView803684330654251895 where mi_idx.movie_id=aggView803684330654251895.v15;
create or replace view aggView4602301535503365989 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin4001119028353166564 as select v15, v28, v29 from aggJoin2877488270420985877 join aggView4602301535503365989 using(v3);
create or replace view aggView763926594090054002 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin4001119028353166564 group by v15;
create or replace view aggJoin6793494822520410082 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView763926594090054002 where mc.movie_id=aggView763926594090054002.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView6564613956157609183 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin965450848846007520 as select v9, v28, v29 from aggJoin6793494822520410082 join aggView6564613956157609183 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin965450848846007520;

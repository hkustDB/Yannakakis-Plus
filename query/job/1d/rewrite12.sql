create or replace view aggView512460517891559544 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin5156235925145314782 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView512460517891559544 where mi_idx.movie_id=aggView512460517891559544.v15;
create or replace view aggView95652654802493673 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1101550758214361071 as select movie_id as v15, note as v9 from movie_companies as mc, aggView95652654802493673 where mc.company_type_id=aggView95652654802493673.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8807649366173271673 as select v15, MIN(v9) as v27 from aggJoin1101550758214361071 group by v15;
create or replace view aggJoin7093356533218587963 as select v3, v28 as v28, v29 as v29, v27 from aggJoin5156235925145314782 join aggView8807649366173271673 using(v15);
create or replace view aggView1963346996279060737 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2730836522797245620 as select v28, v29, v27 from aggJoin7093356533218587963 join aggView1963346996279060737 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2730836522797245620;

create or replace view aggView4191277866905649575 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1316747761953026691 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4191277866905649575 where mc.company_type_id=aggView4191277866905649575.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5775882447295865562 as select v15, MIN(v9) as v27 from aggJoin1316747761953026691 group by v15;
create or replace view aggJoin8851204217228776700 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView5775882447295865562 where t.id=aggView5775882447295865562.v15 and production_year>2000;
create or replace view aggView4879947717934650114 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2946822252282455011 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4879947717934650114 where mi_idx.info_type_id=aggView4879947717934650114.v3;
create or replace view aggView5925248213810957092 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin8851204217228776700 group by v15,v27;
create or replace view aggJoin5556873193833904106 as select v27, v28, v29 from aggJoin2946822252282455011 join aggView5925248213810957092 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5556873193833904106;

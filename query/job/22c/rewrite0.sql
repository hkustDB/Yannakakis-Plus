create or replace view aggView3305587538660231816 as select id as v12 from info_type as it2 where info= 'rating';
create or replace view aggJoin6031601670014826951 as select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView3305587538660231816 where mi_idx.info_type_id=aggView3305587538660231816.v12 and info<'8.5';
create or replace view aggView3182923349597238213 as select id as v17 from kind_type as kt where kind IN ('movie','episode');
create or replace view aggJoin6462909506356600216 as select id as v37, title as v38, production_year as v41 from title as t, aggView3182923349597238213 where t.kind_id=aggView3182923349597238213.v17 and production_year>2005;
create or replace view aggView3004723097649051183 as select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence');
create or replace view aggJoin7275779774225174821 as select movie_id as v37 from movie_keyword as mk, aggView3004723097649051183 where mk.keyword_id=aggView3004723097649051183.v14;
create or replace view aggView881710226928334708 as select v37, MIN(v32) as v50 from aggJoin6031601670014826951 group by v37;
create or replace view aggJoin9090825778900624423 as select v37, v38, v41, v50 from aggJoin6462909506356600216 join aggView881710226928334708 using(v37);
create or replace view aggView8998569122525530173 as select v37, MIN(v50) as v50, MIN(v38) as v51 from aggJoin9090825778900624423 group by v37;
create or replace view aggJoin3295404422487103885 as select movie_id as v37, company_id as v1, company_type_id as v8, note as v23, v50, v51 from movie_companies as mc, aggView8998569122525530173 where mc.movie_id=aggView8998569122525530173.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%';
create or replace view aggView4591646955631576477 as select v1, v8, v37, MIN(v50) as v50, MIN(v51) as v51 from aggJoin3295404422487103885 group by v1,v8,v37;
create or replace view aggJoin4895561136062139851 as select name as v2, country_code as v3, v8, v37, v50, v51 from company_name as cn, aggView4591646955631576477 where cn.id=aggView4591646955631576477.v1 and country_code<> '[us]';
create or replace view aggView8083195257870263985 as select v37, v8, MIN(v50) as v50, MIN(v51) as v51, MIN(v2) as v49 from aggJoin4895561136062139851 group by v37,v8;
create or replace view aggJoin2390754236790486042 as select movie_id as v37, info_type_id as v10, info as v27, v8, v50, v51, v49 from movie_info as mi, aggView8083195257870263985 where mi.movie_id=aggView8083195257870263985.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American');
create or replace view aggView6588186024941707295 as select v37 from aggJoin7275779774225174821 group by v37;
create or replace view aggJoin969809409331980636 as select v37, v10, v27, v8, v50 as v50, v51 as v51, v49 as v49 from aggJoin2390754236790486042 join aggView6588186024941707295 using(v37);
create or replace view aggView3897575023187330997 as select id as v10 from info_type as it1 where info= 'countries';
create or replace view aggJoin5541797700273401275 as select v37, v27, v8, v50, v51, v49 from aggJoin969809409331980636 join aggView3897575023187330997 using(v10);
create or replace view aggView2438499889142830730 as select v8, MIN(v50) as v50, MIN(v51) as v51, MIN(v49) as v49 from aggJoin5541797700273401275 group by v8;
create or replace view aggJoin3159785475555648772 as select id as v8, v50, v51, v49 from company_type as ct, aggView2438499889142830730 where ct.id=aggView2438499889142830730.v8;
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin3159785475555648772;

create or replace view aggView3126132523314712792 as select id as v45, title as v46 from title as t;
create or replace view aggView5203558885474536422 as select id as v36, name as v37 from name as n where gender= 'm';
create or replace view aggJoin1489691423878768631 as (
with aggView4125184266514688892 as (select id as v16 from info_type as it1 where info= 'genres')
select movie_id as v45, info as v26 from movie_info as mi, aggView4125184266514688892 where mi.info_type_id=aggView4125184266514688892.v16);
create or replace view aggJoin4301048084943205154 as (
with aggView4548887147679578234 as (select v45, v26 from aggJoin1489691423878768631 group by v45,v26)
select v45, v26 from aggView4548887147679578234 where v26 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin8448721406204843790 as (
with aggView3267539034580155893 as (select id as v18 from info_type as it2 where info= 'votes')
select movie_id as v45, info as v31 from movie_info_idx as mi_idx, aggView3267539034580155893 where mi_idx.info_type_id=aggView3267539034580155893.v18);
create or replace view aggView2032594404108443276 as select v45, v31 from aggJoin8448721406204843790 group by v45,v31;
create or replace view aggJoin3725115638770556241 as (
with aggView1156297721892089991 as (select v36, MIN(v37) as v59 from aggView5203558885474536422 group by v36)
select movie_id as v45, note as v13, v59 from cast_info as ci, aggView1156297721892089991 where ci.person_id=aggView1156297721892089991.v36 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8411330707637999640 as (
with aggView1336100008900376191 as (select v45, MIN(v31) as v58 from aggView2032594404108443276 group by v45)
select v45, v26, v58 from aggJoin4301048084943205154 join aggView1336100008900376191 using(v45));
create or replace view aggJoin1987621005814753358 as (
with aggView5871530020022592392 as (select v45, MIN(v58) as v58, MIN(v26) as v57 from aggJoin8411330707637999640 group by v45,v58)
select v45, v13, v59 as v59, v58, v57 from aggJoin3725115638770556241 join aggView5871530020022592392 using(v45));
create or replace view aggJoin6227244854919321384 as (
with aggView4900123187102278654 as (select id as v20 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v45 from movie_keyword as mk, aggView4900123187102278654 where mk.keyword_id=aggView4900123187102278654.v20);
create or replace view aggJoin819840173160782295 as (
with aggView5284631952884769439 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView5284631952884769439 where cc.status_id=aggView5284631952884769439.v7);
create or replace view aggJoin550765670080957164 as (
with aggView5586343715097038446 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45 from aggJoin819840173160782295 join aggView5586343715097038446 using(v5));
create or replace view aggJoin2789888050280400781 as (
with aggView3924021535640553253 as (select v45 from aggJoin550765670080957164 group by v45)
select v45 from aggJoin6227244854919321384 join aggView3924021535640553253 using(v45));
create or replace view aggJoin5482584085258188860 as (
with aggView3430584320549000973 as (select v45 from aggJoin2789888050280400781 group by v45)
select v45, v13, v59 as v59, v58 as v58, v57 as v57 from aggJoin1987621005814753358 join aggView3430584320549000973 using(v45));
create or replace view aggJoin1974579247667378134 as (
with aggView6897834395817960735 as (select v45, MIN(v59) as v59, MIN(v58) as v58, MIN(v57) as v57 from aggJoin5482584085258188860 group by v45,v59,v57,v58)
select v46, v59, v58, v57 from aggView3126132523314712792 join aggView6897834395817960735 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59,MIN(v46) as v60 from aggJoin1974579247667378134;
